class KinshipDecorator < Draper::Decorator

  alias :kinship :source
  delegate_all

end
