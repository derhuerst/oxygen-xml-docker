# Oxygen XML Scripting – Docker image

**Docker image for the [Oxygen XML scripting API](https://www.oxygenxml.com/oxygen_scripting.html).**

[![support me via GitHub Sponsors](https://img.shields.io/badge/support%20me-donate-fa7664.svg)](https://github.com/sponsors/derhuerst)
[![chat with me on Twitter](https://img.shields.io/badge/chat%20with%20me-on%20Twitter-1da1f2.svg)](https://twitter.com/derhuerst)

## Usage

*Note:* By using this Docker image, you agree to the EULA. You can view it by running `docker run --entrypoint /bin/cat derhuerst/oxygen-xml EULA_OxygenXML_Editor.txt`.

```shell
docker run \
	-e AGREE_EULA=true \ # agree to EULA
	-it \ # interactive terminal session
	derhuerst/oxygen-xml \
	<oxygen-script-here>
```

For example, let's flatten a tree of XSD files:

```shell
ls xsd/**.xsd
# xsd/schema.xsd
# xsd/sub-schema.xsd

docker run \
	-e AGREE_EULA=true -it \
	-v xsd:/data/xsd \ # mount xsd directory at /data/xsd
	derhuerst/oxygen-xml \
	flattenSchema.sh -in:/data/xsd/schema.xsd -outDir:/data -verbose
```
