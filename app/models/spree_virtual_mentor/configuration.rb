module SpreeVirtualMentor
  class Configuration < Spree::Preferences::Configuration
   # Some example preferences are shown below, for more information visit:
   # https://dev-docs.spreecommerce.org/internals/preferences

   preference :enabled, :boolean, default: true
   preference :fine_tuned_model, :string
   # preference :dark_chocolate, :boolean, default: true
   # preference :color, :string, default: 'Red'
   # preference :favorite_number, :integer
   # preference :supported_locales, :array, default: [:en]
  end
end
