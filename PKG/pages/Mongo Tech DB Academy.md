- [[Spring]] [[Picnic]]
- # Day 1 - 19 April
- OSS document oriented database.
- NoSQL (Not only SQL)
-
- SQL and relation database. And there is everything else.
-
- Schema-less / flexible schema
- Built in **replication** and **scalability** options
- Document = field:value pairs
-
- ## Documents
- Completely different schema's, that is also fine & possible.
-
- ### Hands-on
- `docker run --name my-mongo -d -p 27017:27017 mongo` --> download stuff
- `mongosh --port 27017` --> connect, the port is default though.
- multiple lines will run instead of letting you edit, write `.editor`
-
- Access DB
- `show dbs;`
- `show collections;`
- `db.restaurants.find()`
-
- Expression operators. `{year: {$gt: 2000}}`
- Specify two things for the same fields, use $and operators. or two things per field.
	- If you specify `year` twice, it'll do an OR.
-
- `.sort(... )` can use `name: 1` and -1, former is ascending and latter descending.
- `.skip(10)`
-
- Relational databases `null`
	- Lack of a value
	- DDifferent nulls are not equal
	- Three values structure, boolean, `true`, `false`, `null`. Can't do equality.
- How does MongoDB handle `null`?
	- find name:null --> gets documents with field set to null, or fields where a value is absent.
	- If you want only where value is set to null, then `find : $type : "null"`
	- `{item:  {$exists:false}}`
-
- You can add fields that should be returned when using find.
	- You should use $
-
- If you filter for array and pass multiple values, then it should match the order!!!
- `$elemMatch`, at least one element satisfies both criteria.
- Specify that first element of array matches something. `"dim_cm.0":10`
-
- ---
- MINILAB, get array field
- `db.inventory.find({}, {dim_cm: 1})`
-
- Find at place one, MINI LAB.
- `inventory> db.inventory.find({}, { _id: 0, "Second": {$arrayElemAt: ["$dim_cm", 1]}})`
-
- `db.inventory.find( { 'instock.qty': { $not: { $gte: 20 } } } )` it is flipped, based on "stuff less then 15, we can say this to be smarter". Negate, will fix it.
- ---
- ## Update
- $set
- Rename a field is also possible.
- `$inc` increment.
- db.movies.
-
- ### Update arrays
- `"$set: "grades.$"` .... --> Does only match the first match.
- Add element in array at specific place: `students> db.students.updateOne({ _id: 3 }, { $set: { "grades.3": 101 } })`
- Remove first element of arrays: `students> db.students.updateMany({}, { $pop: { "grades":-1 } })`
-
-
- `album> db.album.updateMany({Name:"Visions"}, {$set: {Genre:"Rock2"}})`
- # Day 2 - 23 April
-
- ## Data Modelling
- Flexible schema; completely different documents in same document.
- no object-relational impedance mismatch.
-
- Defining schema:
	- Usage pattern;
	- How the data is accessed;
	- Critical queries
	- Balance reads and writes.
	- Frequently accessed or historical data.
-
- 16MB limit for a document.
-
- ### How store relations?
- Embedding;
- Linking;
-
- Can lead to a lot of redundant things in the database.
-
- ## Patterns
- Polymorphic: documents in collection are similar but not the same; share some of the attributes.
	- using the `type` field, allows the application to deal with the different set of fields.
-
- Single View Application <-- one big collection. Aggregate data from multiple sources into a central repository.
-
- **Extended reference**:  you can copy over some stuff to the collection, instead of completely "normalized" setup.
- **Subset**: most frequent / recent data in the main collection. The extra stuff can be in an additional collection. Such that we don't read too much to the memory. Mongo only can read _whole_ documents to memory.
- **Computed**: pre-calculate stuff that will be accessed frequently. E.g. save the `number_of_reviews` and `average_stars` in fields.
- **Outlier**: social media app; 16MB BSON document size limit. You can use `Outlier` field, to indicate that there is more information in another collection.
- **Attribute**:  use a field of subdocuments; such that they can have an extra field that makes it easier to search for `stock` for example.
- **Document version**: define a version such that you make clear which version of the document you are looking at.
-
- Exercise:
  ```
   // Posts colletion 
   { 
     _id: 1,
     date: "2022-07-25T14:10:26.113Z",
     author: {
       name: "Name",
       email: "name@mail.com",
       password: "encrypted_stuff",
       last_login: "2022-07-25T14:10:26.113Z"
     }
     text: "Post text",
     status: "published",
     tags: ["tag1", "tag2"]
     comments: [101, 102]
   }
   
   // Comment collection:
   { 
     _id: 101,
     date: "See above",
     author: {
       name: "Name",
       email: "name@mail.com",
       password: "encrypted_stuff",
       last_login: "2022-07-25T14:10:26.113Z"
     }
     text: "Comment",
   }
  ```
-
- ## Aggregation Framework
- Define pipelines using stages. Have collections as input and using the stages you can go to output (also documents).
- ```
  db.<collections>.aggregate([
  {<stage>},
  ...
  {<stage>}
  ])
  ```
- $operator: {<expression>}
-
- $project says what you want to project / return / print out.
-
- $skip
- $limit
- $group --> _id: <expression>
-
-
-
-
- # Day 3
- $unwind
- $bucket
- $bucketAuto
- $lookup
-
- ## Performance
- Explain feature.
-
- Compound indexes, indexes on two or more fields.
-
- The order should match if you pass the params for the queries. IF you do compound index.
-
- Equality, sort, range. It is important to do it in this order.
-
- Multikey Indexes:
-
- ## Covered queries
- `db.users.createIndex( { "userMetadata.$**" : 1 } );`
- wildcard index ^
-
- Indexes options;
	- Unique options.
-
- Partial indexes.
-
- TTL Indexes
	- Single-field indexes that mongoDB can use to automatically remove documents after a specific time.
-
- # Day 4
- The order _kind of_ matters. You should at least use all fields that are part of the index. For the find you have two parts, `filter` and `projection` in the `filter` you need to use both parts that are part of the index. Using one in the `filter` and one in the `projection` then it doesn't work.
-
- ## EQUALITY SORT RANGE
-
- ## Architecture
-