module Inflector
  module CoreExtensions
    module String
      def pluralize
        Inflector.pluralize(self)
      end
      
      def singularize
        Inflector.singularize(self)
      end
      
      def camelize
        Inflector.camelize(self)
      end
      
      def underscore
        Inflector.underscore(self)
      end
      
      def pascalize
        Inflector.pascalize(self)
      end
      
      def constantize
        Inflector.constantize(self)
      end
      
      def uncapitalize
        Inflector.uncapitalize(self)
      end
    end
  end
end
