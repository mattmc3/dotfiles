#!/usr/bin/env python3

'''
binergen.py

Generates a JSON file from a TOML mapping for Karabiner-Elements.

```bash
DEST_DIR=$HOME/.config/karabiner/assets/complex_modifications
mkdir -p $DEST_DIR
./binergen.py mylayer.toml > $DEST_DIR/mylayer.json
```
'''

import sys
import json
import re
from collections import namedtuple
from pathlib import Path
import toml
from enum import Enum

# mappings to get back to qwerty, which Karabiner requires
colemak_to_qwerty_map = dict(zip(list("fpgjluy;rstdneiok"),
                                 list("ertyuiopsdfgjkl;n")))

colemak_dh_to_qwerty_map = dict(zip(list("fpbjluy;rstkneiodvmh"),
                                   list("ertyuiopsdfhjkl;vbnm")))

dvorak_to_qwerty_map = dict(zip(list("[]',.pyfgcrl/=oeuidhtns-;qjkxbwvz"),
                                list("-=qwertyuiop[]sdfghjkl;'zxcvbn,./")))

KeyAction = namedtuple('KeyAction', 'action key_code modifiers')
MouseAction = namedtuple('MouseAction', 'action movement direction')
mouse_action_map = {
    "scroll": {
        "left": MouseAction('MouseAction', "horizontal_wheel", 1),
        "right": MouseAction('MouseAction', "horizontal_wheel", -1),
        "up": MouseAction('MouseAction', "vertical_wheel", -1),
        "down": MouseAction('MouseAction', "vertical_wheel", 1),
    },
    "move": {
        "left": MouseAction('MouseAction', "x", 1),
        "right": MouseAction('MouseAction', "x", -1),
        "up": MouseAction('MouseAction', "y", -1),
        "down": MouseAction('MouseAction', "y", 1),
    },
}
mouse_button_map = {
    "left": 1,
    "right": 2,
    "middle": 3,
}

# https://github.com/tekezo/Karabiner-Elements/issues/925
karabiner_map = {
    "-": "hyphen",
    "=": "equal_sign",
    "[": "open_bracket",
    "]": "close_bracket",
    ";": "semicolon",
    "'": "quote",
    ".": "period",
    ",": "comma",
    "/": "slash",
    "\\": "backslash",
    "\\2": "non_us_backslash",  # backslash #2
    "`": "grave_accent_and_tilde",
    "space": "spacebar",
    "enter": "return_or_enter",
    "return": "return_or_enter",
    "esc": "escape",
    "ins": "insert",
    "delete": "delete_or_backspace",
    "backspace": "delete_or_backspace",
    "pgup": "page_up",
    "pgdn": "page_down",
    "up": "up_arrow",
    "left": "left_arrow",
    "down": "down_arrow",
    "right": "right_arrow",
    "cmd": "left_command",
    "ctrl": "left_control",
    "shift": "left_shift",
    "opt": "left_option",
    "alt": "left_option",
}

modifers_set = set([
    "left_command",
    "left_control",
    "left_shift",
    "left_option",
])


class JsonBuilder():
    ''' Builder for Karabiner JSON '''
    def __init__(self, config):
        self.config = config
        self.keyboard = self.config.get('keyboard', 'qwerty')
        self.layer_name = self.config.get('layer-name', 'custom_layer')
        self.mouse_scroll_distance = int(self.config.get('mouse-scroll-distance', 50))
        self.mouse_move_distance = int(self.config.get('mouse-move-distance', 1500))
        self.scroll_mod = -1 if self.config.get('natural-scrolling', False) else 1
        self._karabiner = None

        self._build_root()
        for mapping in self.config['mappings'].items():
            self._build_mapping(mapping)

    def json(self):
        return json.dumps(self._karabiner, indent=2)

    def _build_root(self):
        title = self.config.get('title', 'Custom Layer')
        description = self.config.get('description', 'No description provided')
        self.keyboard = self.config.get('keyboard', 'qwerty')
        modifier = standardize_key(self.config.get('switch-layer-modifier', 'caps_lock'), self.keyboard)
        alone_action = standardize_key(self.config.get('switch-layer-modifier-alone-action', 'delete_or_backspace'), self.keyboard)
        self._karabiner = {'title': title,
                           'rules': [{'description': description,
                           'manipulators': [{'from': {'key_code': modifier},
                             'to': [{'set_variable': {'name': self.layer_name, 'value': 1}}],
                             'to_after_key_up': [{'set_variable': {'name': self.layer_name, 'value': 0}}],
                             'to_if_alone': [{'key_code': alone_action}],
                             'type': 'basic'}]}]}

    def _build_mapping(self, mapping):
        from_action = parse_key_sequence(mapping[0], self.keyboard)
        from_mapping = self._build_from_mapping(from_action)
        to_action = parse_key_sequence(mapping[1], self.keyboard)
        to_mapping = self._build_to_mapping(to_action)

        result = {'type': 'basic',
                  'conditions': [{'name': self.layer_name, 'type': 'variable_if', 'value': 1}],
                  'from': from_mapping,
                  'to': to_mapping,
                 }
        self._karabiner['rules'][0]['manipulators'].append(result)

    def _build_from_mapping(self, action):
        if action.action != 'KeyAction':
            raise ValueError("Expecting only a KeyAction for from mappings")
        result = {'key_code': action.key_code}
        if action.key_code not in modifers_set:
            result['modifiers'] = {'optional': ['any']}
        return result

    def _build_to_mapping(self, action):
        result = {}
        if action.action == 'KeyAction':
            result['key_code'] = action.key_code
            if action.key_code not in modifers_set and len(action.modifiers) > 0:
                result['modifiers'] = action.modifiers
        else:
            if action.movement == 'pointing_button':
                result['pointing_button'] = action.direction
            else:
                distance = self.mouse_scroll_distance if re.search(r'_wheel', action.movement) else self.mouse_move_distance
                distance *= self.scroll_mod if action.movement in ('up', 'down') else 1
                result['mouse_key'] = {action.movement: distance * action.direction}
        return [result]


def standardize_key(key_code, keyboard):
    ''' switch to qwerty because that's what Karabiner knows '''
    result = key_code.lower()
    kbconverter = {}
    if keyboard == "colemak":
        kbconverter = colemak_to_qwerty_map
    elif keyboard == "colemak_dh":
        kbconverter = colemak_dh_to_qwerty_map
    elif keyboard == "dvorak":
        kbconverter = dvorak_to_qwerty_map
    result = kbconverter.get(result, result)
    result = karabiner_map.get(result, result)
    return result


def parse_key_sequence(key_sequence, keyboard):
    # parsing logic
    key_sequence = "hyphen" if key_sequence == "-" else key_sequence.lower()
    keyboard = keyboard.lower().replace("-", "")

    if re.match("mouse_", key_sequence):
        # mouse codes are in format: mouse_action_direction, like mouse_click_left
        _, movement, direction = key_sequence.split("_")
        if movement == "click":
            button_num = 'button{}'.format(mouse_button_map[direction])
            return MouseAction('MouseAction', 'pointing_button', button_num)
        return mouse_action_map[movement][direction]
    else:
        # split the modifiers from the keys
        keys = []
        modifiers = []
        for key_code in key_sequence.split("-"):
            karabiner_key = standardize_key(key_code, keyboard)
            if karabiner_key in modifers_set:
                modifiers.append(karabiner_key)
            else:
                # f-keys mean we automatically need the function modifier
                if re.search(r'^f\d+$', karabiner_key):
                    modifiers.append("fn")
                keys.append(karabiner_key)

        # if the only thing picked was a modifier, make it the primary
        if len(keys) == 0 and len(modifiers) > 0:
            keys, modifiers = modifiers, keys
        elif len(keys) > 1:
            raise ValueError("Invalid key code: {}".format(key_sequence))

        # set the keyboard key being pressed
        return KeyAction('KeyAction', keys[0], modifiers)


def main():
    ''' main method for program execution '''
    if len(sys.argv) != 2:
        raise ValueError("Missing toml config for layer")

    config_file = Path(sys.argv[1])
    config = toml.load(config_file)
    builder = JsonBuilder(config)
    print(builder.json())


if __name__ == '__main__':
    main()
