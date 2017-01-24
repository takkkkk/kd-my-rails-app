require "open3"

def exec_pandoc(input, from)
  pandoc_command = "pandoc -f #{from} -t html"
  logger.debug 'pandoc_command: ' + pandoc_command
  output, status = Open3.capture2(pandoc_command, :stdin_data=>input)
  output
end

class MainController < ApplicationController
  def index
    @histories = History.all

    @input_md = ''
    @output_pandoc = ''
    @output_github = ''
    @output_multi = ''
  end

  def convert
    @histories = History.all

    if params[:id].present?
      @history = History.find(params[:id])
      @input_md = @history.input_md
    else
      @history = History.new
      @input_md = params[:'input-markdown']
    end

    @output_pandoc = exec_pandoc(@input_md, 'markdown')
    @output_github = exec_pandoc(@input_md, 'markdown_github')
    @output_multi  = exec_pandoc(@input_md, 'markdown_mmd')

    @history.time_exec = Time.zone.now
    @history.input_md = @input_md
    @history.output_pandoc = @output_pandoc
    @history.output_github = @output_github
    @history.output_multi = @output_multi
    @history.save

    render action: :index
  end
end
