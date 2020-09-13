module BuildingTools

    class Apartment

        attr_accessor :number, :people, :base_bills, :var_bills, :fines

        def initialize(number)
            @number = number
            @people = []
            @base_bills = 0.0
            @var_bills = 0.0
            @fines = 0.0
        end
    end

    class Person

        attr_reader :name, :age, :role

        def initialize(name, age, role)
            @name = name
            @age = age
            @role = role
        end
    end

    class Office
        
        attr_accessor :people

        def initialize(parent)
            @people = []
            @building = parent
        end

        def fine(apt_number, quantity)
            @building.apartments.each do |apt|
                apt.fines += quantity if apt_number == apt.number
            end
        end

        def update_bills
            @building.apartments.each do |apt|
                apt.base_bills = @building.fixed_fee
                apt.var_bills = @building.var_fee * apt.people.length
            end
        end

        def mod_fees(percentage)
            @building.fixed_fee *= 1 + (percentage / 100.0)
            @building.var_fee *= 1 + (percentage / 100.0)
            update_bills
        end
    end
end