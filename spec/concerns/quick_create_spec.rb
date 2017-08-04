require 'ostruct'

class QuickCreateSetupTestController < ApplicationController
  include QuickCreate
end

describe QuickCreateSetupTestController do
  it 'should return a render_checkbox hash' do
    data = OpenStruct.new({ id: 1, name: 'Friends' })
    data_type = 'category'
    create_type = 'moment'
    render_checkbox = subject.render_checkbox(data, data_type, create_type)

    expect(render_checkbox[:checkbox]).to eq '<input type="checkbox" value="1"
    name="moment[category][]"
    id="moment_category_1">'
    expect(render_checkbox[:label]).to eq '<span>Friends</span><br>'
    expect(render_checkbox[:wrapper_id]).to eq 'category_name_1'
    expect(render_checkbox[:autocomplete_id]).to eq 'moment_category_name'
  end
end
