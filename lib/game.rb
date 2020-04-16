class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars # Разбиваем загаданое слово на буквы [Ё, Ж, И, К]
    @user_guesses = [] # Массив для букв, введенных пользователем
  end

  def errors # 7
    # Получаем массив ошибочных букв [К, Л, М, С]
    return normalized_letters(@user_guesses) - normalized_letters(@letters)
  end

  def errors_made # 6
    return errors.length # Получаем длину массива ошибочных букв 4
  end

  def errors_allowed # 5 Проверяем количество разрешенных ошибок
    return TOTAL_ERRORS_ALLOWED - errors_made # Получаем количество попыток 7 - 4 = 3
  end

  def letters_to_guess
    result =
      @letters.map do |letter| # Берем массив букв из слова [Ё, Ж, И, К]
        if normalized_letters(@user_guesses).include?(normalize_letter(letter)) # Если буква уже вводилась
          letter # возвращаем букву
        else
          nil  # иначе __
        end
      end
    return result
  end

  def lost? # 4 Проверяем проиграна ли
    return errors_allowed == 0 #Проиграно, если дозволено ошибок 0
  end

  def over? # 1
    return won? || lost? # Игра будет закончена, если выграна или проиграна
  end

  def play!(user_letter) # 2 передаем букву Ё
    # Если не закончена и букву еще не вводили
    if !over? && !normalized_letters(@user_guesses).include?(normalize_letter(user_letter))
      @user_guesses << user_letter
    end
  end

  def won? # 3 Проверяем выиграна ли
    return (normalized_letters(@letters) - normalized_letters(@user_guesses)).empty? # Вычетаем из массива слова буквы пользователя
  end

  def word
    return @letters.join # Собираем слово из массива
  end

  def normalize_letter(letter)
    return 'Е' if letter == 'Ё'
    return 'И' if letter == 'Й'
    letter
  end

  def normalized_letters(letters)
    letters.map { |letter| normalize_letter(letter) }
  end
end
