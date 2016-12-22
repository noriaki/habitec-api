Rails.application.routes.draw do
  :kindles.tap do |resource|
    resources resource, only: [ :show, :create ]
    patch "/#{resource}/:id", to: "#{resource}#update"
  end
end
