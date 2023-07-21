class Details
  attr_reader :title, 
              :vote_average, 
              :runtime, 
              :genres, 
              :summary,
              :default_runtime,
              :id,
              :poster

  def initialize(data)
    @title = data[:title]
    @vote_average = data[:vote_average]
    @runtime = format_time(data[:runtime])
    @default_runtime = data[:runtime]
    @genres = data[:genres]
    @summary = data[:overview]
    @id = data[:id]
    @poster = data[:poster_path]
  end

  def format_time(i)
    mod = i % 60
    hours = i / 60

    "#{hours}h #{mod}m"
  end
end
