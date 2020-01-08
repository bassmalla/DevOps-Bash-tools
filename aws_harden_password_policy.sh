#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2020-01-07 11:57:18 +0000 (Tue, 07 Jan 2020)
#
#  https://github.com/harisekhon/bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

# Strengthens password policy according to CIS Foundations Benchmark recommendations
#
# View password policy using adjacent script aws_password_policy.sh (automatically called at start and end of this script)

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(dirname "${BASH_SOURCE[0]}")"

echo
echo "Existing Password Policy:"
echo
"$srcdir/aws_password_policy.sh"
echo
echo
echo "Setting Hardened Password Policy:"
echo
set -x
aws iam update-account-password-policy --require-uppercase-characters
aws iam update-account-password-policy --require-lowercase-characters
aws iam update-account-password-policy --require-symbols
aws iam update-account-password-policy --require-numbers
aws iam update-account-password-policy --minimum-password-length 14
aws iam update-account-password-policy --password-reuse-prevention 24
aws iam update-account-password-policy --max-password-age 90
set +x
echo
echo
echo "New Password Policy:"
echo
"$srcdir/aws_password_policy.sh"