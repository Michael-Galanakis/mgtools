
#'@export
directory_line_count <- \(path, ...) {
  files = list.files(path, full.name = TRUE, ...)
  file_name = basename(files)
  line_count = sapply(files, \(file_name) readLines(file_name) |> length())
  result = data.frame(file_name = file_name, line_count = line_count)
  result = result[order(-result$line_count),]
  if ('package:data.table' %in% search()) {
    return(as.data.table(result))
  }
  return(result)
}

