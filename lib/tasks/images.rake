require 'rake'

namespace :images do
  # Run `bundle exec rake images:convert_to_webp` to excute this task.
  desc 'Convert PNG and JPG images to WebP format and update references'
  task convert_to_webp: :environment do
    require 'image_processing/vips'

    def update_file_references(old_path, _new_path)
      old_ext = File.extname(old_path)
      old_basename = File.basename(old_path, old_ext)
      pattern = "#{old_basename}#{old_ext}"
      webp_name = "#{old_basename}.webp"

      # Find all relevant file types that might contain image references
      files_to_check = Dir.glob([
        'app/**/*.{rb,erb,js,jsx,ts,tsx,css,scss}',
        'client/**/*.{js,jsx,ts,tsx,css,scss}',
        'config/**/*.{rb,yml}',
        'doc/**/*.{json,md}'
      ])

      files_to_check.each do |file_path|
        next unless File.file?(file_path)
        content = File.read(file_path)
        
        # Replace various forms of the image reference
        replacements = {
          pattern => webp_name,
          pattern.gsub('/', '\\/') => webp_name,  # Handle escaped paths
          pattern.gsub('.', '\\.') => webp_name   # Handle escaped extensions
        }

        changes_made = false
        replacements.each do |old_str, new_str|
          if content.include?(old_str)
            content = content.gsub(old_str, new_str)
            changes_made = true
          end
        end

        if changes_made
          File.write(file_path, content)
          puts "Updated references in: #{file_path}"
        end
      end
    end

    def convert_to_webp(file_path)
      # Skip if WebP version already exists
      webp_path = file_path.sub(/\.(png|jpg|jpeg)$/i, '.webp')
      return if File.exist?(webp_path)

      begin
        puts "Converting: #{file_path}"
        pipeline = ImageProcessing::Vips
          .source(file_path)
          .convert('webp')
          .call(destination: webp_path)
        
        if File.exist?(webp_path)
          puts "Successfully converted to: #{webp_path}"
          # Update any code references to this image
          update_file_references(file_path, webp_path)
          # Delete the original file
          File.delete(file_path)
          puts "Deleted original file: #{file_path}"
        end
      rescue => e
        puts "Error converting #{file_path}: #{e.message}"
      end
    end

    # Find all PNG and JPG files in the project
    image_files = Dir.glob([
      'app/assets/images/**/*.{png,jpg,jpeg}',
      'public/**/*.{png,jpg,jpeg}',
      'client/app/assets/images/**/*.{png,jpg,jpeg}'
    ], File::FNM_CASEFOLD)

    if image_files.empty?
      puts "No PNG or JPG files found to convert."
      next
    end

    puts "Found #{image_files.length} images to convert..."
    
    image_files.each do |file|
      convert_to_webp(file)
    end

    puts "Conversion process completed!"
  end
end
