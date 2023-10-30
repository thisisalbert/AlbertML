FROM rocker/tidyverse:4.3.1
LABEL maintainer="Albert Garcia Lopez albertgarcialopez313@gmail.com"

# Variables
ENV N_CORES="4"
ENV CRAN_MIRROR="https://packagemanager.rstudio.com/cran/2023-10-06"

# Set the CRAN mirror to the specific snapshot date
RUN echo "options(repos = c(CRAN = '$CRAN_MIRROR'))" >> /etc/R/Rprofile.site

# Copy settings, keybinds, and typographic fonts
COPY . /home/rstudio/.config/rstudio

# Install CRAN R packages required for machine learning
RUN install2.r -e -n $N_CORES \
	tidymodels \
	caret \
	rio \
	janitor \
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
	pacman \
	skimr \
	purrr \
	magrittr \
	svMisc \
	kknn \
	ranger \
	igraph \
	themis \
	ggvenn \
	progress \
	ggExtra \
	doMC \
	BiocManager

# Install Bioconductor packages
RUN R -e "BiocManager::install(c('AnnotationDbi', 'org.Hs.eg.db'))"

# Install InformationValue (discontinued, last version is 1.2.3)
RUN R -e "devtools::install_version('InformationValue', '1.2.3')"

# Install DMwR (discontinued, last version is 0.4.1)
RUN R -e "devtools::install_version('DMwR', '0.4.1')"

# Install addins
RUN R -e "devtools::install_github('rstudio/addinexamples', type = 'source')" \
	R -e "devtools::install_github('ThinkR-open/littleboxes')" \
	R -e "devtools::install_github('fkeck/quickview')" \
	R -e "devtools::install_github('daattali/colourpicker')" \
	R -e "devtools::install_github('strboul/caseconverter')" \
	R -e "devtools::install_github('stevenpawley/recipeselectors')"

# Final cleanup
RUN apt-get -y autoclean \
	&& apt-get -y autoremove \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Initialize container
SHELL ["/bin/bash", "-c"]
EXPOSE 8787
CMD ["/init"]
