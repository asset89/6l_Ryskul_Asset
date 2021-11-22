//
//  main.swift
//  6l_Ryskul_Asset
//
//  Created by Asset Ryskul on 19.11.2021.
//

// MARK: - Структура для коллекции вида Queue с дженериком <Type>
struct Queue<Type> {
    // формируем массив вида "очередь"
    var elements = [Type]()
    
    // метод для добавления
    mutating func add(_ element: Type) {
        elements.append(element)
    }
    
    // метод для извлечения
    mutating func poll() -> Type? {
        elements.removeFirst()
    }
    
    // сабскрипт, возвращает элемент с заданным индексом или nil
    subscript(index: Int) -> Type? {
        if index < elements.count {
            return elements[index]
        } else {
            return nil
        }
    }
}

// MARK: - Протокол Flight, описывающий все что может летать
protocol Flight {
    var maxFlightHeight: Double { get }  // максимальная высота полета
    var weight: Double { get }           // масса
    
    func canFly()  // метод полета
}

// MARK: - Класс Plane, описывающий пассажирские и транспортные самолеты
class Plane: Flight {
    
    var model: String {         // модель самолета
        didSet {
            print("Plane with model of \(self.model)")
        }
    }
    var releaseYear: Int        // год выпуска
    var maxFlightHeight: Double // свойства протокола Flight
    var weight: Double          // свойства протокола Flight
    
    init( model: String, releaseYear: Int, height: Double, weight: Double) {
        self.model = model
        self.releaseYear = releaseYear
        self.maxFlightHeight = height
        self.weight = weight
    }
    
    func canFly() {
        print("Plane can fly to height of \(self.maxFlightHeight) m")
    }
    
}

// MARK: - Класс Bird, описывающий все виды птиц
class Bird {
    var name: String       // название птицы
    var species: String    // семейство
    
    init(name: String, species: String) {
        self.name = name
        self.species = species
    }
}

// MARK: - Класс FlightBird, описывающий все виды птиц которые могут летать
class FlightBird: Bird, Flight {

    var maxFlightHeight: Double // свойства протокола Flight
    var weight: Double          // свойства протокола Flight
    
    init(name: String, species: String, height: Double, weight: Double) {
        self.maxFlightHeight = height
        self.weight = weight
        super.init(name: name, species: species)   // наследование из класса Bird
    }
    
    func canFly() {
        print("\(self.name) can fly to maximal height of \(self.maxFlightHeight) m")
    }
    
    
}

// MARK: - создаем экземпляры классов Plane и FlightBird
var plane1 = Plane(model: "Boeng", releaseYear: 2015, height: 6000, weight: 220)
var bird1 = FlightBird(name: "Орел", species: "Хищные", height: 3000, weight: 5)
var plane2 = Plane(model: "Airbus", releaseYear: 2020, height: 6500, weight: 300)
var bird2 = FlightBird(name: "Воробей", species: "Пернатый", height: 200, weight: 0.2)

// MARK: - создаем коллекцию вида "очередь" или Queue с типом Flight
var queue = Queue<Flight>()

// добавляем элементы в коллекцию queue
queue.add(plane1)
queue.add(plane2)
queue.add(bird1)
queue.add(bird2)

print(queue) // возвращает Queue<Flight>(elements: [_l_Ryskul_Asset.Plane, _l_Ryskul_Asset.Plane, _l_Ryskul_Asset.FlightBird, _l_Ryskul_Asset.FlightBird])

// Сортируем по высоте полета с помощью замыкания sort
queue.elements.sort { $0.maxFlightHeight > $1.maxFlightHeight }

// выводим на печать результат сортировки
for element in queue.elements {
    print(element.maxFlightHeight)
}

// переводим массы из килограммов в фунты
var weights_in_pounds = queue.elements.map { $0.weight * 2.2 }

// выводим на печать результат отображения
print(weights_in_pounds)

// проверяем действие сабскрипта
if let q = queue[0] {
    print(q.maxFlightHeight)
} else {
    print("Нет значения")
}

if let r = queue[5] {
    print(r.maxFlightHeight)
} else {
    print("Нет значения")
}

// извлекаем элементы из коллекции queue
print(queue.poll()?.maxFlightHeight)








