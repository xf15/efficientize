dict_writing = read.csv("data-raw/dict_writing.csv", quote = "\"")

usethis::use_data(dict_writing, overwrite = TRUE)


dict_psyexp = read.csv("data-raw/dict_psyexp.csv", quote = "\"")

usethis::use_data(dict_psyexp, overwrite = TRUE)
