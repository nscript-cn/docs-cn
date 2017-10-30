#!/bin/bash

get_artifacts() {
    BUILD_NAME="$1"
    shift
    
    while (( "$#" )) ; do
        ARTIFACT_ID="$1"
        shift

        JENKINS_PREFIX="http://nsbuild01.telerik.com:8080/build/view/Docs/job/"
        JENKINS_SUFFIX="/lastSuccessfulBuild/deployedArtifacts/download/artifact.$ARTIFACT_ID/"
        URL="$JENKINS_PREFIX$BUILD_NAME$JENKINS_SUFFIX"

        wget --clobber --content-disposition "$URL"
        echo "URL: $URL"
    done
}

get_dependencies() {
    rm -rf *.tar.gz
    rm -rf _dependencies
    mkdir -p _dependencies
       #Build NS Core modules docs
    #Copy code snippets and cookbook content
    (cd NativeScript && \
        ./build-docs.sh)
    cp -R ./NativeScript/bin/dist/snippets _dependencies/snippets/
    cp -R ./NativeScript/bin/dist/cookbook _dependencies/cookbook/

    #Build NS SDK examples docs
    #Copy the code content
    (cd nativescript-sdk-examples-ng && \
        ./build-docs.sh)
    cp -R ./nativescript-sdk-examples-ng/dist/code-samples _dependencies/code-samples/

    #Build NS Sidekick docs
    (cd sidekick-docs &&
        jekyll build)
}

get_postbuild_dependencies() {
    #Copy NS Core modules API reference
    cp -R ./NativeScript/bin/dist/api-reference dist/api-reference/

    #Copy NS Sidekick docs content
    cp -R ./sidekick-docs/sidekick dist/sidekick/
}
