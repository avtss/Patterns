class File_strategy
    def load(file_path)
      raise NotImplementedError, 'Метод load не реализован в классе FileStrategy'
    end
  
    def save(file_path, data)
      raise NotImplementedError, 'Метод save не реализован в классе FileStrategy'
    end
  end