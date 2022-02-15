library(stringr)

setwd('/Users/mq20185996/Dropbox/teaching/2022/cogs2020/live_course_material/')
out_format <- 'html_document'
in_files <- list.files(getwd(), pattern='*.Rmd', full.names=T)

make <- function(in_file) {
    rmarkdown::render(
                   in_file,
                   output_format = out_format,
                   output_file = str_replace(in_file, '.Rmd', '.html'),
                   knit_root_dir=getwd()
               )
}

for(in_file in in_files) {
  make(in_file)
}
