FROM rocker/tidyverse:4.3.0

LABEL maintainer="Albert Garcia Lopez https://github.com/thisisalbert"

# Variables
ENV N_CORES="4"
ENV CRAN_MIRROR=https://packagemanager.rstudio.com/cran/2023-05-15/

# Create user "albert" and set it as the home directory
RUN useradd -ms /bin/bash albert
ENV HOME=/home/albert
WORKDIR $HOME

# Set the CRAN mirror to a frozen repository
RUN echo "options(repos = c(CRAN = '$CRAN_MIRROR'))" > /etc/R/Rprofile.site

# Install Linux dependencies
RUN apt update && apt install -y \
	build-essential \
	libglpk40 \
	libpng-dev \
	libxml2-dev \
	libcurl4-openssl-dev \
	libssl-dev \
	libgit2-dev \
	libv8-dev \
	libbz2-dev \
	liblzma-dev

# Install CRAN R packages required for machine learning
RUN install2.r -e -n $N_CORES \
	pacman \
	rio \
	tidymodels \
	caret \
	ROSE \
	PRROC \
	kernlab \
	e1071 \
	caTools \
	Boruta \
	vita \
	doParallel \
	DescTools \
	paletteer \
	skimr \
	purrr \
	magrittr \
	janitor \
	svMisc \
	kknn \
	ranger \
	igraph \
	themis

# Install addins
RUN R -e "install.packages(c('devtools', 'remotes'), repos = '$CRAN_MIRROR'); \
	devtools::install_github(c('rstudio/addinexamples', 'ThinkR-open/littleboxes', 'fkeck/quickview', 'daattali/colourpicker', 'strboul/caseconverter', 'stevenpawley/recipeselectors'), type = 'source')"

# Final cleanup
RUN apt-get -y autoclean \
	&& apt-get -y autoremove \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy custom RStudio theme
COPY dracula_custom.rstheme $HOME

# Initialize container
EXPOSE 8787
CMD ["/init"]
