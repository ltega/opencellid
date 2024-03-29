class Cell < ActiveRecord::Base
  has_many :measures
  
  def computePos
    lat=0.0
    lon=0.0
	nbSamples=0
    self.measures.each do |mes|
	   if mes.lat!=nil and mes.lon !=nil
		lat+=mes.lat
		lon+=mes.lon
		nbSamples+=1
	   end
    end
    self.nbSamples=nbSamples
    self.lat=lat/nbSamples
    self.lon=lon/nbSamples
	self.needsComputation=false
    self.save
  end
  
  def Cell.computeAverage cells
    cell=Cell.new
    if cells.size>0
      cells.each do |c|
        cell.lat=cell.lat+c.lat
        cell.lon=cell.lon+c.lon
      end
    
      cell.lat=cell.lat/cells.size
      cell.lon=cell.lon/cells.size
      c=cells.first
      cell.mcc=c.mcc
      cell.mnc=c.mnc
      cell.lac=c.lac
      cell.range=1000  # need to be computed here!
      cell.updated_at=Time.now
      cell.nbSamples=cells.size
    end
    cell
  end
  
  def operator
    Operators.find_by_mcc_and_mnc(self.mcc,self.mnc)
  end
  
  def operatorName
    begin
    Operators.find_by_mcc_and_mnc(self.mcc,self.mnc).name
      
    rescue
      "not know"
    end
  end
  
  def Cell.cleanPos
	cells=Cell.find_all_by_needsComputation(true,:limit=>10000)
	cells.each do |cell|
		cell.computePos
	end
	return cells.size
  end
  
  def Cell.getSizeByCountry(mcc)
    begin
       Cell.find_by_sql("SELECT count(*) as res from cells where mcc="+mcc.to_s)[0].attributes["res"].to_i
    rescue =>e
       logger.info e.to_s
    end
  end
  
  def country
     begin
          Country.find(self.mcc)
      rescue
      end
  end
end
