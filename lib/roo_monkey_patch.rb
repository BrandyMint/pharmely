class Roo::Excel
  def platform_specific_encoding(value)                                                                      
    # > @workbook.encoding
    # => #<Encoding:CP850>

    result =                                                                                                 
      value.encode('ibm850').force_encoding('cp1251').encode('utf-8') 

    if every_second_null?(result)                                                                            
      result = remove_every_second_null(result)                                                              
    end                                                                                                      
    result                                                                                                   
  end                                                                                                        

end
