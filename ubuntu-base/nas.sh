 docker build . -t myubuntu
 docker run -d --name u00 -p 2322:22 -v ~/console:/data myubuntu