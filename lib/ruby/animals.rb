require "ruby/animals/version"

module RubyAnimals
  DB ||= PG.connect({:dbname => 'animals'})
  module Something
    def self.findBy(key, value)
      PG.exec("SELECT * FROM #{self.TABLE} WHERE #{key} = #{value};")
    end

    def self.delete
      PG.exec("DELETE FROM #{self.TABLE} WHERE id = #{id};")
    end

    def self.update(key, value, condition)
      PG.exec("UPDATE #{self.TABLE} SET #{key} = #{value} WHERE #{condition}")
    end

    def self.find(name)
      findBy('name', name)
    end

    def findAll
      PG.exec("SELECT * FROM #{self.TABLE}")
    end
  end

  class Animal
    TABLE = 'animals'
    include RubyAnimals::Something

    def self.create(properties, owner_id = nil)
      sql = "Insert INTO #{self.TABLE} (name, gender, admit_date, type, breed, owner_id) VALUES ($1, $2, $3, $4, $5)"
      if owner_id.nil?
        sql = "Insert INTO #{self.TABLE} (name, gender, admit_date, type, breed) VALUES ($1, $2, $3, $4)"
      end
      PG.exec_params(sql, properties)
    end

  end

  class Customer
    TABLE = 'customers'
    include RubyAnimals::Something

    def self.create(properties)
      sql = "Insert INTO #{self.TABLE} (name, phone, pref_type, pref_breed) VALUES ($1, $2, $3, $4) returning id"
      PG.exec_params(sql, properties)
    end

  end
end
