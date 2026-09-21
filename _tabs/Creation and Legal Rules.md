---
title: Creation and Legal Rules
layout: page
icon: fas fa-stream
order: 1
category_name: "Creation and Legal Rules"
---

{% assign matching_posts = site.posts | where_exp: "post", "post.categories contains 'Creation and Legal Rules'" %}
{% for post in matching_posts %}
### [{{ post.title }}]({{ post.url | relative_url }})

{{ post.excerpt | strip_html | truncatewords: 40 }}
{% endfor %}
