module ApplicationHelper
	def display_error_message(errors, field_name, display_name = nil, no_name = false)
		html = ""
		if errors.present?
			field_name = field_name.to_sym
			display_name = display_name.present? ? display_name : field_name.capitalize
			if errors["bank_errors"].present? && errors[field_name].present?
				html = "<span class='text-red'>#{errors[field_name].join(',')}</span>".html_safe
			elsif errors[field_name].present? && no_name
        html = "<span class='text-red'>#{errors[field_name].join(',')}</span>".html_safe
      elsif errors[field_name].present?
				html = "<span class='text-red'>#{display_name} #{errors[field_name].join(',')}</span>".html_safe
			end
		end
		html
	end

	def topic_tag_label(topic)
		label_tag = ['warning','success','danger','default','primary']
		return topic.tag_list.map.with_index { |t,index| link_to(t, tag_path(t), class: "label label-#{label_tag[rand(0...5)]}")}.join(' ')
	end

	def truncate_html_data(html)
		return truncate_html(html, length: 250, omission: '...(continued)')
	end

	def popular_tags(num)
		popular_tag = ActsAsTaggableOn::Tag.most_used(num).pluck(:name)
		label_tag = ['warning','success','danger','default','primary']
		return popular_tag.map.with_index {|t, index| link_to(t, tag_path(t), class: "label label-#{label_tag[rand(0...5)]}")}.join(' ')
	end

	def popular_topics(num)
		popular_tag = ActsAsTaggableOn::Tag.most_used(num).pluck(:name).uniq
		return Topic.tagged_with(popular_tag, :any => true).limit(num)
	end
end
