# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).

![question1_logical_model drawio](https://github.com/lynnc00/sql/assets/167378358/58e2fdee-7ba9-489f-bac3-84aa91f7b68c)



## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.
![question_2_logical_model drawio](https://github.com/lynnc00/sql/assets/167378358/bca64e92-5694-47e0-9c1d-46ead8ab64fc)



## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

Bonus: Are there privacy implications to this, why or why not?
```
Type 1: Overwrite
customer_address
customer_id
address
city
state
country
zipcode

Type 2: Retain changes
customer_address
customer_id
customer_address_id
address
city
state
country
change_date

Privacy implication: To record customer’s historical address may result in privacy concerns since they’re related to the personal information, and Type2 method can rise more serious issues. It’s critical to implement data protection regulations and obtain customer’s consent to store the data, and ensure all the customer data is protected in the database.
```




## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
Main differences:

1.	AdventureWorks schema is nomarlized and more complicated than my EDR. It includes more tables and relationships between different datasets to support a business system. But EDR is a fundamental table to showcase the simple databased for the needs of bookstore management.
2.	AdventureWorks schema owns different tables along with the different systems for sales/purchasing/person/production/humanresources/dbo, and its tables may contain couples of Primary keys and Foreign Keys to connect each other. But my EDR has fewer tables with less PK or FK that works for the basic data managemement.

Possible changes:

1.	I might add more complicated tables to enhance the “Supplier” with book inventory ordering system to record the ordering details includes shipment and processing information
2.	I will improve the details of information for both purchasing and sales information, storing more detailed customer information such as credit cards and purchase status.

```



# Criteria

[Assignment Rubric](./assignment_rubric.md)

# Submission Information

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

### Submission Parameters:
* Submission Due Date: `June 1, 2024`
* The branch name for your repo should be: `model-design`
* What to submit for this assignment:
    * This markdown (design_a_logical_model.md) should be populated.
    * Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pull/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [ ] Create a branch called `model-design`.
- [ ] Ensure that the repository is public.
- [ ] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-3-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
