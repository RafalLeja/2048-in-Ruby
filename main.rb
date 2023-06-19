# These lines of code are importing various Ruby files that contain classes and methods used in the
# game. `require 'ruby2d'` imports the Ruby2D library, while the `require_relative` statements import
# custom classes and modules used in the game, such as `Intro`, `Scene`, `InputField`, `Blok`, `Grid`,
# `ScoreCounter`, and `Leaderboard`.
require 'ruby2d'
require_relative 'Scene'
require_relative 'SceneManager'
require_relative 'InputField'
require_relative 'Block'
require_relative 'Grid'
require_relative 'ScoreCounter'
require_relative 'Leaderboard'

# https://coderspacket.com/creating-a-puzzle-game-2048-in-c

colorBackground = Color.new('#a66a35')
colorForeground = Color.new('#804f25')

# These lines of code are setting various properties of the game window using the Ruby2D library.
set title: "2048 by Rafał Leja"
set background: colorBackground
set resizable: true
set width: 960
set height: 540

# This code block is checking if a file named "score" exists in the current directory. If it does, it
# opens the file in read mode, reads its contents into a string variable `tmpStr`, and then uses the
# `Marshal.load` method to deserialize the contents of `tmpStr` into a hash object `scoreTable`. If
# the file does not exist, it creates a new hash object `scoreTable` with a default value of -1.

playerScore = ["", 0]

# These lines of code are creating instances of the `Scene` class and initializing them with various
# objects such as `Text`, `InputField`, `Grid`, `ScoreCounter`, and `Leaderboard`. These scenes will
# be used to display different parts of the game, such as the introduction screen, the game board, and
# the leaderboard.
intro = Scene.new([
  Text.new( 
    "2048", 
    x: Window.width/2 - 70,
    y: Window.height/14,
    size: 70
    ),
  Text.new( 
    "by Rafał Leja", 
    x: Window.width/2 - 35,
    y: Window.height/5,
    size: 14
    ),
  Text.new(
    "Type in the player name:",
    x: Window.width/2 - 185,
    y: Window.height/4,
    size: 35
    ),
    InputField.new( 
      text: playerScore,
      x: Window.width/2,
      y: Window.height/2.5,
      size: 40
      ),
    Text.new(
      "Move blocks with w, a, s, d. The game ends when the board is full",
      x: Window.width/2 - 280,
      y: Window.height*0.6,
      size: 20
      ),
    Text.new(
      "Press ENTER to start the game",
      x: Window.width/2 - 130,
      y: Window.height*0.8,
      size: 20
      )
])

game = Scene.new([
  grid = Grid.new(Window),
  ScoreCounter.new(
    grid,
    playerScore,
    x: Window.width/10,
    y: Window.height/10,
    size: 20
  )
])

finish = Scene.new([
  Text.new(
    "Leaderboard:",
    x: Window.width/2 - 130,
    y: Window.height*0.05,
    size: 50
  ),
  Leaderboard.new(
    playerScore, 
    x: Window.width*0.3,
    y: Window.height*0.2,
    size: 30
    )
]) 


# `state = [0]` is creating an array `state` with an initial value of 0. This array will be used to
# store the game state in an array because unlike the `Int` class, the `Array` class is passed as a
# pointer, which allows it to be changed in other classes.

scenes = SceneManager.new([intro, game, finish])

# This code block is setting up an event listener for the `:key_up` event, which is triggered when a
# key is released on the keyboard. When this event is triggered, the code block calls the `event`
# method of the current scene object (`scenes[state[0]]`) and passes in the `event` object and the
# `state` array as arguments. This allows the scene object to handle the event and update the game
# state accordingly.
on :key_up do |event|
  scenes.event(event)
end

# This code block is continuously updating the game window by clearing the previous frame (`clear`)
# and then adding the current frame (`scenes[state[0]].add()`) based on the current state of the game
# (`state[0]`). This allows the game to display different scenes and update the game state in
# real-time.
update do
  clear
  scenes.add()
end

show
