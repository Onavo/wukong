/*
 A script to generate Wikipedia page graph edge list
 Accepts as input 2 tsvs: list of pages and list of links
 Link table should initially be formatted as from_page_id, into_namespace, into_title
 Link table is transformed to from_id, into_id, from_namespace, from_title,  into_namespace, into_title
 Assumes that the combination of namespace and title uniquely identifies a page
*/
page_metadata = LOAD '$page_metadata' AS (id:int, namespace:int, title:chararray, restrictions:chararray, counter:long, is_redirect:int, is_new:int, random:float, touched:int, page_latest:int, len:int);
links = LOAD '$pagelinks_extracted' AS (from_id:int, into_namespace:int, into_title:chararray);

first_pass_j = JOIN page_metadata BY id RIGHT OUTER, links BY from_id;
first_pass   = FOREACH first_pass_j GENERATE 
  links::from_id AS from_id, page_metadata::namespace AS from_namespace, page_metadata::title AS from_title,
  links::into_namespace AS into_namespace, links::into_title AS into_title;
second_pass_j = JOIN page_metadata BY (namespace, title) RIGHT OUTER, first_pass BY (into_namespace, into_title);
second_pass   = FOREACH second_pass_j GENERATE 
  first_pass::from_id, page_metadata::id,
  first_pass::from_namespace, first_pass::from_title, 
  first_pass::into_namespace, first_pass::into_title;
STORE second_pass INTO '$pagelinks_augmented';
