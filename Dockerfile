FROM texlive/texlive:latest AS container

RUN apt-get update && apt-get install -y latex2html
