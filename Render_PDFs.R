# This Script renders all Presentations as PDFs and saves them imto the folder /pdf
library(rmarkdown)

# On WIndows: setwd("~/R Bootcamp")
setwd("~/Documents/R-Projekte/R-Bootcamp")

all_md <- grep(pattern = ".+\\/(?!R|readme).+[^R]md", list.files(recursive = TRUE), perl = T, value = T)

for (i in seq_along(all_md)) {
  render(all_md[i], output_format = "pdf_document", output_dir = "pdfs", knit_root_dir = "pdfs")
}
