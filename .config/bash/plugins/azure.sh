function azdbtok {
  local tok="$(az account get-access-token --resource https://ossrdbms-aad.database.windows.net --query accessToken --output tsv)"
  echo "$tok" | tee >(pbcopy) >(cat)
}
