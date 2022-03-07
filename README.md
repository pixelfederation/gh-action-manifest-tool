# Manifest tool

This Action uses the [manifest-tool](https://github.com/estesp/manifest-tool) to push multi-platform container images to oci 2.2 comaptible container registry.

## Usage

## Example pipeline
```yaml
- name: Push manifest
  uses: pixelfederation/gh-action-manifest-tool@v0.1.0 #check for latest tag
  with:
    username: ${{ secrets.REGISTRY_USERNAME }}
    password: ${{ secrets.REGISTRY_PASSWORD }}
    platforms: linux/amd64,linux/arm64
    template: ${{ env.registry }}/${{ env.image_name  }}:${{ env.image_tag }}-ARCH
    target: ${{ env.registry }}/${{ env.image_name  }}:${{ env.image_tag }}
# see https://github.com/estesp/manifest-tool to understand template
```

## Required Arguments

| variable         | description                                                    | required | default  |
|------------------|----------------------------------------------------------------|----------|----------|
| template         | repo:tag source for inputs using placeholders OS,ARCH, VARIANT | true     |          |
| target           | repo:tag for multiarch manifest upload                         | true     |          |

## Optional Arguments

| variable              | description                                                     | required | default         |
|-----------------------|-----------------------------------------------------------------|----------|-----------------|
| username              | Username used for authentication to the Docker registry         | false    | $GITHUB_ACTOR   |
| password              | Password used for authentication to the Docker registry         | false    | $GITHUB_TOKEN   |
| platforms             | coma separated list of platforms                                | false    | linux/amd64     |
| target                | Sets the target stage to build                                  | false    |                 |
| manifest_tool_bin     | path to manifest tool binary, autodetected see entrypoint       | false    |                 |
