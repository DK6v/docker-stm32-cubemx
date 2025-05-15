## Build the image

STM32CubeMX installer is not included in the repository.
Put the installation archive into the *docker* directory (for example, *en.stm32cubemx-lin-v6-14-1.zip*), and then build the image.

Find the suitable Linux installation package using the link provided below:
<https://www.st.com/en/development-tools/stm32cubemx.html>

## Getting started

```shell
docker compose build
docker compose up
# or
make build
make run
```
