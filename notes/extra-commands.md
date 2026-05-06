# 1. Set Okular as default for PDFs

xdg-mime default okularApplication_pdf.desktop application/pdf

# 2. Set OnlyOffice as default for Microsoft Office formats

xdg-mime default org.onlyoffice.desktopeditors.desktop application/msword
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-excel
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-powerpoint

# Also set for modern OOXML formats (optional but recommended)

xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.openxmlformats-officedocument.wordprocessingml.document
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.openxmlformats-officedocument.presentationml.presentation

# 3. Set GIMP as default for common image formats

xdg-mime default gimp.desktop image/jpeg
xdg-mime default gimp.desktop image/png
xdg-mime default gimp.desktop image/gif
xdg-mime default gimp.desktop image/tiff
xdg-mime default gimp.desktop image/bmp
xdg-mime default gimp.desktop image/webp
