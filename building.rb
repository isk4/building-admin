require_relative 'building_tools'

class Building
    
    include BuildingTools

    attr_accessor :apartments, :fixed_fee, :var_fee

    def initialize(apartments_quantity, max_people)
        @apartments = []
        @max_people = max_people
        apartments_quantity.times do
            @apartments << Apartment.new(@apartments.length + 1)
        end
        @office = Office.new(self)
        @fixed_fee = 50000.0
        @var_fee = 20000.0
        @office.update_bills
    end

    def add_person(apt_number, name, age)
        @apartments.each do |apt|
            if apt_number == apt.number && apt.people.length < @max_people
                apt.people << Person.new(name, age, "habitant")
                @office.update_bills
            end
        end
    end
    
    def add_employee(name, age, role)
        @office.people << Person.new(name, age, role)
    end

    def kick_person(apt_number, name, age)
        @apartments.each do |apt|
            if apt_number == apt.number
                apt.people.each do |person|
                    apt.people.delete(person) if name == person.name && age == person.age
                    @office.update_bills
                end
            end
        end
    end

    def kick_employee(name, age, role)
        @office.people.each do |person|
            if name == person.name && age == person.age && role == person.role
                @office.people.delete(person)
            end
        end
    end

    def to_s
        result = "\nDepartamentos: #{@apartments.length}\n"
        result += "Máximo de personas por departamento: #{@max_people}\n\n"
        @apartments.each do |apt|
            result += "Número de departamento: #{apt.number}\n"
            result += "Habitantes:\n\n"
            apt.people.each do |person|
                result += "- Nombre: #{person.name} | Edad: #{person.age}\n"
            end
            result += "\nGastos fijos: #{apt.base_bills}\n"
            result += "Gastos variables: #{apt.var_bills}\n"
            result += "Multas: #{apt.fines}\n"
            result += "----------------------------\n"
        end
        result += "Trabajadores:\n\n"
        @office.people.each do |person|
            result += "- Nombre: #{person.name} | Edad: #{person.age} | Cargo: #{person.role}\n"
        end
        return result
    end
end