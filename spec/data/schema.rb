ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do

  create_table :test_symmetries, force: true do |t|
    t.string :name
    t.timestamps
  end

  create_table :test_double_symmetries, force: true do |t|
    t.string :name
    t.timestamps
  end

end
