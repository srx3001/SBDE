read_cufflinks <- function(task) {
  resFile <- task$file("cuffdiff.zip")
  resFile$download(tempdir())
  pathZIP <- paste0(tempdir(), "/", resFile$name)
  unzip(pathZIP, files = "gene_exp.diff", exdir = tempdir())
  path <- paste0(tempdir(),"/gene_exp.diff")

  # If there are multiple features with the same name in the gtf, cuffdiff may add
  # " (1 of many)" to their names in the gene_exp.diff. This will unable us to
  # read.table() so we need to remove those.
  x <- readLines(path)
  y <- gsub("(1 of many)", "", x, fixed = TRUE)
  # NEEDS TO BE SAVED IN SOME TEMP FILES FOLDER
  new_path <- paste0(tools::file_path_sans_ext(path), "_mod.", tools::file_ext(path))
  cat(y, file=new_path, sep="\n")

  cdResults <- read.table(file=new_path, header=TRUE, stringsAsFactors=FALSE)
  file.remove(pathZIP, path, new_path)
  return(data.frame(row.names = cdResults$gene_id, "q_value" = cdResults$q_value,
                    stringsAsFactors=FALSE))
}

read_deseq2 <- function(task) {
  resFile <- task$file("out.csv")
  if (is.null(resFile)) stop("There was no csv file in the task outputs.")
  resFile$download(tempdir())
  path <- paste0(tempdir(), "/", resFile$name)

  ds2Results <- read.csv(file=path, header=TRUE, stringsAsFactors=FALSE)
  file.remove(path)
  return(data.frame(row.names = ds2Results$X, "q_value" = ds2Results$padj,
                    stringsAsFactors=FALSE))
}


read_edger <- function(task) {
  resFile <- task$file("out.csv")
  if (is.null(resFile)) stop("There was no csv file in the task outputs.")
  resFile$download(tempdir())
  path <- paste0(tempdir(), "/", resFile$name)

  edgerResults <- read.csv(file=path, header=TRUE, stringsAsFactors=FALSE, sep="\t")
  file.remove(path)
  return(data.frame(row.names = row.names(edgerResults), "q_value" = edgerResults$FDR,
                    stringsAsFactors=FALSE))
}

read_shrinkbayes <- function(task) {
  resFile <- task$file("out.csv")
  if (is.null(resFile)) stop("There was no csv file in the task outputs.")
  resFile$download(tempdir())
  path <- paste0(tempdir(), "/", resFile$name)

  sbResults <- read.csv(file=path, header=TRUE, stringsAsFactors=FALSE, sep="\t")
  file.remove(path)
  return(data.frame(row.names = sbResults$Names, "q_value" = sbResults$BFDRs,
                    stringsAsFactors=FALSE))
}

