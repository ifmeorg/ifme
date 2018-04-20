namespace :metrics do
  task :lines do
    lines, codelines, total_lines, total_codelines = 0, 0, 0, 0
    for file_name in FileList["lib/**/*.rb"]
      f = File.open(file_name)
      while line = f.gets
        lines += 1
        next if line =~ /^\s*$/
        next if line =~ /^\s*#/
        codelines += 1
      end
      puts "L: #{sprintf("%4d", lines)}, " +
        "LOC #{sprintf("%4d", codelines)} | #{file_name}"
      total_lines     += lines
      total_codelines += codelines

      lines, codelines = 0, 0
    end

    puts "Code: Lines #{total_lines}, LOC #{total_codelines}\n\n"

    lines, codelines, total_lines, total_codelines = 0, 0, 0, 0
    for file_name in FileList["spec/**/*_spec.rb"]
      f = File.open(file_name)
      while line = f.gets
        lines += 1
        next if line =~ /^\s*$/
        next if line =~ /^\s*#/
        codelines += 1
      end
      puts "L: #{sprintf("%4d", lines)}, " +
        "LOC #{sprintf("%4d", codelines)} | #{file_name}"
      total_lines     += lines
      total_codelines += codelines

      lines, codelines = 0, 0
    end

    puts "Specs: Lines #{total_lines}, LOC #{total_codelines}\n\n"
  end
end
