require 'tk'
root = TkRoot.new {title "Dismaland Tour"}

content = Tk::Tile::Frame.new(root) {padding "3 3 2 2"}.grid(sticky: 'nsew')
$name = Tk::Tile::Label.new(content) {text "name"}.grid(column: 0, row: 0, :sticky => 'we')
$image = TkPhotoImage.new
$image.file = "images/dolphin_toilet_bowl.gif"
img_label = TkLabel.new(content) {textvariable $description}
img_label.image = $image
img_label.grid(column: 0, row: 1)


buttons = Tk::Tile::Frame.new(content) {padding "3 3 2 2"}.grid(sticky: 'nsew', column: 0, row: 2)

Tk::Tile::Button.new(buttons) {text 'NW'; command {click("NW")}}.grid(column: 0, row: 0)
Tk::Tile::Button.new(buttons) {text 'N'; command {click("N")}}.grid(column: 1, row: 0)
Tk::Tile::Button.new(buttons) {text 'NE'; command {click("NE")}}.grid(column: 2, row: 0)
Tk::Tile::Button.new(buttons) {text 'W'; command {click("W")}}.grid(column: 0, row: 1)
Tk::Tile::Button.new(buttons) {text 'E'; command {click("E")}}.grid(column: 2, row: 1)
Tk::Tile::Button.new(buttons) {text 'SW'; command {click("SW")}}.grid(column: 0, row: 2)
Tk::Tile::Button.new(buttons) {text 'S'; command {click("S")}}.grid(column: 1, row: 2)
Tk::Tile::Button.new(buttons) {text 'SE'; command {click("SE")}}.grid(column: 2, row: 2)

def click(info)
  $name.text = "Button #{info} pressed!"
  # Note that you can directly change the image filename and it updates :)
  if info == "W"
    $image.file = "images/parking_lot.gif"
  end
end

Tk.mainloop
