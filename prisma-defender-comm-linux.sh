#!/bin/bash
# This Bash script can be used to deploy a host Defender.
# To use, update the 4 variables prefixed with `PCC_` below.

# If using SaaS, PCC_USER and PCC_PASS will be an access key and secret key.
PCC_USER=e3da5879-f40c-474b-9028-2c6e643fa082
PCC_PASS=uI4ZYdP3nbSlqKRu9W5i7Gjesw0=

# If using SaaS, PCC_URL should be the exact value copied from
# Compute > Manage > System > Utilities > Path to Console
PCC_URL="https://us-east1.cloud.twistlock.com/us-1-113062108"

# This will be PCC_URL without the scheme prefix and any path suffix
PCC_DOMAIN_NAME=us-east1.cloud.twistlock.com

json_auth_data="$(printf '{ "username": "%s", "password": "%s" }' "${PCC_USER}" "${PCC_PASS}")"
token=$(curl -sSLk -d "$json_auth_data" -H 'content-type: application/json' "$PCC_URL/api/v1/authenticate" | python3 -c 'import sys, json; print(json.load(sys.stdin)["token"])')
curl -sSLk -H "authorization: Bearer $token" -X POST "$PCC_URL/api/v1/scripts/defender.sh" | bash -s -- -c "$PCC_DOMAIN_NAME" -d "none" --install-host