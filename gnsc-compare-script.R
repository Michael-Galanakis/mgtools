devtools::load_all()
compare.subdir = \(subdir, ...) {
  current = 'C:/Users/MichaelGalanakis/omicronbycims/eSystems by CIMS - C - Workspace/2 Sponsors/NBCD/GNSC-001-101/current/' |>
    file.path(subdir)
  interim = sub('/current/', '/current - IA/', current)
  diff.folder.mtime(current, interim, ...)
}

compare.subdir('05_Programs/TLF/NBCD.GNSC.001.101/vignette',
  pattern = '\\.R$')
compare.subdir('05_Programs/TLF/NBCD.GNSC.001.101/R/')
compare.subdir('05_Programs/ADAM', pattern='*.sas')
compare.subdir('05_Programs/SDTM', pattern='*.sas')
