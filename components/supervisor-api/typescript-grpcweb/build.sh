#!/bin/bash
# Copyright (c) 2020 TypeFox GmbH. All rights reserved.
# Licensed under the GNU Affero General Public License (AGPL).
# See License-AGPL.txt in the project root for license information.


THIRD_PARTY_INCLUDES=${PROTOLOC:-$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway}
if [ ! -d $THIRD_PARTY_INCLUDES/third_party/googleapis ]; then
    tmpdir=$(mktemp -d)
    git clone https://github.com/grpc-ecosystem/grpc-gateway $tmpdir
    THIRD_PARTY_INCLUDES=$tmpdir
fi

mkdir -p lib
export PROTO_INCLUDE="-I$THIRD_PARTY_INCLUDES/third_party/googleapis -I /usr/lib/protoc/include"

protoc $PROTO_INCLUDE --plugin="protoc-gen-ts=`which protoc-gen-ts`" --js_out="import_style=commonjs,binary:lib" --ts_out="service=grpc-web:lib" -I${PROTOLOC:-..} ${PROTOLOC:-..}/*.proto