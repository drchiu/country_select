# CountrySelect
module ActionView
  module Helpers
    module FormOptionsHelper
      # Return select and option tags for the given object and method, using country_options_for_select to generate the list of option tags.
      def country_select(object, method, removed_countries = nil, priority_countries = nil, options = {}, html_options = {})
        InstanceTag.new(object, method, self, options.delete(:object)).to_country_select_tag(removed_countries, priority_countries, options, html_options)
      end
      
      # Add an option to remove from COUNTRIES constant options that have already been selected
      def remove_options(original, removed_selection)
        result = original - removed_selection if (removed_selection && removed_selection.class==Array)
      end 
      
      def set_world_regions_option(removed_countries)
        if removed_countries
          world_regions_options = ""
          na_countries = NA_COUNTRIES-removed_countries
          european_countries = EUROPEAN_COUNTRIES-removed_countries
          unless na_countries.empty?
            @divider = true
            world_regions_options += options_for_select("North American Countries")
          end
          unless european_countries.empty?
            @divider = true
            world_regions_options += options_for_select("European Countries") 
          end
        end
      end
      
      def set_rest_of_world_option(removed_selection)
        @divider = true
        if removed_selection.include?("Rest of World")
          ''
        else
          options_for_select("Rest of World")
        end
      end
      
      # Returns a string of option tags for pretty much any country in the world. Supply a country name as +selected+ to
      # have it marked as the selected option tag. You can also supply an array of countries as +priority_countries+, so
      # that they will be listed above the rest of the (long) list.
      #
      # NOTE: Only the option tags are returned, you have to wrap this call in a regular HTML select tag.
      def country_options_for_select(selected = nil, removed_countries = nil, priority_countries = nil, world_regions = false, rest_of_world = false)
        country_options = ""
        
        if removed_countries
          # removes it from the existing priority countries
          priority_countries -= removed_countries
          countries_constant = COUNTRIES-removed_countries
        else
          countries_constant = COUNTRIES
          removed_countries = []
        end

        if !priority_countries.empty?
          @divider = true
          country_options += options_for_select(priority_countries, selected)
        end
        
        country_options += set_world_regions_option(removed_countries) if world_regions
        
        country_options += set_rest_of_world_option(removed_countries) if rest_of_world
        
        # add a spacer between priority countries/regions to the rest of the countries
        if @divider
          country_options += "<option value=\"\" disabled=\"disabled\">-------------</option>\n"
        end

        return country_options + options_for_select(countries_constant, selected)
      end
      # All the countries included in the country_options output.
      COUNTRIES = ["Afghanistan", "Aland Islands", "Albania", "Algeria", "American Samoa", "Andorra", "Angola",
        "Anguilla", "Antarctica", "Antigua And Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria",
        "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin",
        "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegowina", "Botswana", "Bouvet Island", "Brazil",
        "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia",
        "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China",
        "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo",
        "Congo, the Democratic Republic of the", "Cook Islands", "Costa Rica", "Cote d'Ivoire", "Croatia", "Cuba",
        "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt",
        "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)",
        "Faroe Islands", "Fiji", "Finland", "France", "French Guiana", "French Polynesia",
        "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guernsey", "Guinea",
        "Guinea-Bissau", "Guyana", "Haiti", "Heard and McDonald Islands", "Holy See (Vatican City State)",
        "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran, Islamic Republic of", "Iraq",
        "Ireland", "Isle of Man", "Israel", "Italy", "Jamaica", "Japan", "Jersey", "Jordan", "Kazakhstan", "Kenya",
        "Kiribati", "Korea, Democratic People's Republic of", "Korea, Republic of", "Kuwait", "Kyrgyzstan",
        "Lao People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libyan Arab Jamahiriya",
        "Liechtenstein", "Lithuania", "Luxembourg", "Macao", "Macedonia, The Former Yugoslav Republic Of",
        "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique",
        "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of",
        "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru",
        "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger",
        "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau",
        "Palestinian Territory, Occupied", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines",
        "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation",
        "Rwanda", "Saint Barthelemy", "Saint Helena", "Saint Kitts and Nevis", "Saint Lucia",
        "Saint Pierre and Miquelon", "Saint Vincent and the Grenadines", "Samoa", "San Marino",
        "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore",
        "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa",
        "South Georgia and the South Sandwich Islands", "Spain", "Sri Lanka", "Sudan", "Suriname",
        "Svalbard and Jan Mayen", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic",
        "Taiwan, Province of China", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Timor-Leste",
        "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan",
        "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom",
        "United States", "United States Minor Outlying Islands", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela",
        "Viet Nam", "Virgin Islands, British", "Virgin Islands, U.S.", "Wallis and Futuna", "Western Sahara",
        "Yemen", "Zambia", "Zimbabwe"] unless const_defined?("COUNTRIES")
    end
    
    #
    # Continents => Countries
    #

    NA_COUNTRIES = ["Canada", "United States", "Mexico"] unless const_defined?("NA_COUNTRIES")

    EUROPEAN_COUNTRIES = ["Austria", "Belgium", "Croatia", "Czech Republic", "Denmark", "Finland", "France", "Germany",
        "Greece", "Hungary", "Iceland", "Ireland", "Italy", "Luxembourg", "Netherlands", "Norway", "Poland", "Portugal",
        "Romania", "Slovakia", "Spain", "Sweden", "Switzerland", "United Kingdom"] unless const_defined?("EUROPEAN_COUNTRIES")
    
    class InstanceTag
      def to_country_select_tag(removed_countries, priority_countries, options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = value(object)
        content_tag("select",
          add_options(
            country_options_for_select(value, removed_countries, priority_countries, options[:world_regions], options[:rest_of_world]),
            options, value
          ), html_options
        )
      end
    end
    
    class FormBuilder
      def country_select(method, removed_countries = nil, priority_countries = nil, options = {}, html_options = {})
        @template.country_select(@object_name, method, removed_countries, priority_countries, options.merge(:object => @object), html_options)
      end
    end
  end
end