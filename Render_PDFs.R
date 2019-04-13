# This Script renders all Presentations as PDFs and saves them imto the folder /pdf
library(rmarkdown)

all_md <- grep(pattern = ".+\\/(?!R|readme).+[^R]md", list.files(recursive = TRUE), perl = T, value = T)

lapply(all_md, render, output_format = "pdf_document", output_dir = "pdf")
render("mydoc.md", output_format = "pdf_document", output_dir = "pdf")
