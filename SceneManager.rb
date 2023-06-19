class SceneManager
    def initialize(scenes)
      @scenes = scenes
      @current = [0]
    end
  
    def add()
      @scenes[@current[0]].add()
    end
  
    def event(e)
      @scenes[@current[0]].event(e, @current)
    end
  end