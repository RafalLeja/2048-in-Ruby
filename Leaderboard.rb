# The Leaderboard class manages the saving and displaying of player scores in a game.
class Leaderboard

  def initialize(playerScore, x: 0, y: 0, size: 30)
    @playerScore = playerScore
    @x = x
    @y = y
    @size = size
    @saved = false

    if File.exists?("score")
      scoreFile = File.open("score", "r")
      tmpStr = scoreFile.read
      @scoreTable = Marshal.load(tmpStr)
      @scoreTable.default = -1
    else
      @scoreTable = Hash.new(-1)
    end

  end

##
# This function saves the player's score to a file and updates the score table.
  def save()
    if @scoreTable[@playerScore[0]] == -1
      @scoreTable[@playerScore[0]] = @playerScore[1]  
    elsif @scoreTable[@playerScore[0]] < @playerScore[1]
      @scoreTable.delete(@playerScore[0])
      @scoreTable[@playerScore[0]] = @playerScore[1]  
    end
    
    @scoreTable = @scoreTable.sort_by {|k, v| -v}.to_h
    
    tmpStr = Marshal.dump(@scoreTable)
    File.write("score", tmpStr)
  end

##
# The function adds scores to a table and displays the top 8 scores in a text table.
  def add()
    if !@saved
      save()
      @saved = true
    end

    tmpArray = @scoreTable.to_a

    textTable = []

    numberOfEntries = [8, tmpArray.length].min - 1

    for i in 0..numberOfEntries do
      textTable.push(Text.new(
        (i+1).to_s + ". " + tmpArray[i][0] + ": " + tmpArray[i][1].to_s,
        x: @x,
        y: @y + i*2*@size,
        size: @size
      ))
    end
  end

##
# This is a Ruby function that checks if the key pressed is "return" and closes the event if it is.
# 
# Args:
#   e: This parameter refers to an event object, which could be triggered by a user action such
# as pressing a key on the keyboard or clicking a button. The code is checking for a specific
# key press event, as indicated by the line `c = e.key.to_s`.
#   s: The parameter "s" is not used in the given code snippet, so it is difficult to determine its
# purpose without additional context.
  def event(e, s)
    c = e.key.to_s
    if c == "return"
      close
    end
  end
end