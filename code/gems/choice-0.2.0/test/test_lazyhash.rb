$:.unshift "../lib:lib"
require 'test/unit'
require 'choice/lazyhash'

class TestLazyHash < Test::Unit::TestCase
  
  def test_symbol
    name = 'Igor'
    age = 41
    
    hash = Choice::LazyHash.new
    hash['name'] = name
    hash[:age] = age
   
    assert_equal name, hash[:name]
    assert_equal age, hash[:age]
  end
  
  def test_string
    name = "Frank Stein"
    age = 30
    
    hash = Choice::LazyHash.new
    hash[:name] = name
    hash['age'] = age
    
    assert_equal name, hash['name']
    assert_equal age, hash['age']
  end
  
  def test_store_and_fetch
    name = 'Jimini Jeremiah'
    job = 'Interior Decorator'
    
    hash = Choice::LazyHash.new
    hash.store('name', name)
    hash.store(:job, job)
    
    assert_equal name, hash.fetch(:name)
    assert_equal job, hash.fetch('job')
  end
  
  def test_messages
    star = 'Sol'
    planet = 'Mars'

    hash = Choice::LazyHash.new
    hash.star = star
    hash.planet = planet

    assert_equal star, hash.star
    assert_equal planet, hash.planet
  end

  def test_from_hash
    state = 'Nebraska'
    country = 'Mexico'

    hash = { :state => state, :country => country }
    lazy = Choice::LazyHash.new(hash)

    assert_equal state, lazy['state']
    assert_equal country, lazy[:country]
  end
  
  def test_to_lazyhash
    hash = { :name => 'Jimmy', :age => 25 }
    lazy = hash.to_lazyhash

    assert_equal hash[:name], lazy.name
    assert_equal hash[:name], lazy[:name]
    assert_equal hash[:age], lazy.age
    assert_equal hash[:age], lazy[:age]
  end

end
