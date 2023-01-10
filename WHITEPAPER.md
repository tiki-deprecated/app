# TIKI DAO

By: Barry O'Connor and Mike Audi, TIKI inc.

*Abstract — The internet lacks a fair market value (FMV) for data, the price at which it would change hands between a willing and informed buyer and seller. Without it, poor outcomes and distrust continue. Fair market values require free markets, economic systems in which sellers and buyers determine the prices of goods and services without the intervention of government or external authority. Without intervention does not mean devoid of standards, guidelines, and processes, but rather self-organizing by market participants.*

*Tiki inc. (TIKI) is building a decentralized data exchange (data DEX) and is responsible for defining the rules. Traditionally the corporation dictates these rules, violating the non-intervention requirement of a free market. TIKI DAO satisfies both the need for governance and non-intervention, putting the rules of engagement in market participants' hands. Using a non-transferable tokenized reputation system, buyers and sellers propose and vote to adopt standards, guidelines, and processes for the TIKI data DEX.*

### I. INTRODUCTION
The TIKI DAO (decentralized autonomous organization) is a self-organizing community of participants in the TIKI data DEX who, through a series of software-based proposals and voting, maintain the governance protocol for the DEX.

Take the Apple App Store, where developers must follow [Apple's Review Guidelines](https://developer.apple.com/app-store/review/guidelines) to publish their mobile app to the marketplace. Now, instead of Apple determining these guidelines, what if the developers collectively decided them? This is the premise of TIKI DAO, but for the TIKI ecosystem.

#### A. Core Components
There are three components to understanding the function of the TIKI DAO:

*Token Issuance* – incentivizing and measuring participation.

*Proposal and Voting* – the process for maintaining the DAO and the Governance Protocol.

*Governance Protocol* – the resulting set of rules, guidelines, and standards for the TIKI data DEX as a rolling outcome from the Proposal and Voting process. 

### II. Token Issuance

TIKI DAO utilizes non-transferable, time-based, depreciating reputation tokens earned through participation in the TIKI ecosystem.

#### B. Non-transferable

When governance is [transferable](https://ntnsndr.mirror.xyz/zO27EOn9P_62jVlautpZD5hHB7ycf3Cfc2N6byz6DOk), it frequently skews in a direction that does not best represent the community and the long-term success of the governed property, favouring a concentration of power in a wealthy minority.

This is a significant concern for markets where businesses transact directly with consumers. Companies retain dramatically more wealth and maintain longer time horizons compared to people.

A non-transferable ([soulbound](https://vitalik.ca/general/2022/01/26/soulbound.html)) token awarded based on active ecosystem participation is a more accurate representation of stake and removes the risk of entities buying up concentrated interests.

#### C. Reputation

Without transference, the DAO requires an alternative mechanism to calculate total influence, called reputation. While the most straightforward method would be a one-to-one summation, the goal is to represent active participation. A token issued today should carry more weight than one issued years ago. For this, we use a time-based depreciation model connected to the token type. Tokens start with an initial value (e.g., 1.0) and depreciate over time until reaching a resting value (e.g., 0.0). For example, a one-year depreciating token starting at 1.0 with a resting value of 0.0 has a value of 0.5 at six months post-issuance. Total reputation is the sum of token values. To incentivize continued engagement, token payout $f_{i}$ includes a 5% bonus based on the previous reputation balance $(f_{i-1})$.

$$
\displaylines{
p\left(x\right)=\ participation\ reward\\
f_i(x)\ =\ p(x)\ +\ 0.05f_{i-1}
}
$$

<p align="center"><sub>Fig. 1 Equation for token payout</sub></p>


The DAO will initially support two types of soulbound depreciative tokens:

*1YT* - a linear daily depreciation from 1.0 to 0.0, spanning one year

*3YT* - a linear daily depreciation from 1.0 to 0.0, spanning three years

#### D.	Participation Rewards

Users and companies earn token rewards through DAO-approved participatory actions in the TIKI ecosystem.

##### a.	People

*Connect Account* – When a user links a data source account (e.g., social media or an email), the user will get a reward of 10 1YT tokens per month per account. 

*Data Pooling Setup* – Users who agree to pool their data will receive 20 1YT tokens as a once-off reward. 

*Data Pooling* – Users will receive ten 1YT tokens every month per active data source pooling data. 

*Refer a Friend* – A user who recommends a friend through a referral code will receive a reward of 30 1YT tokens on the friend's registration. 

*Refer a Company* – A user who recommends a company through a referral code issued by the DAO will receive a reward of 40 1YT tokens on registration of the company.

*Voting* – Every time users vote or participate in a poll, they will receive 20 1YT tokens. 

*Company Nomination* – At the end of every 12 months, there is a list of companies that deserve credit for something outstanding or unacceptable. A merit or demerit list. The users will create this list. Every user who nominates a company will earn 100 1YT tokens if their company finishes top or bottom three. 

*Promotion* – Users who create an attributable social post about TIKI (using hashtags) will receive 30 1YT tokens.

*Bug Hunting* – Any bug report accepted by the TIKI team will receive a bounty of 80 1YT tokens.

##### b.	Companies

*TIKI SDK* – A company that adds TIKI's SDK to their production application is awarded 350 3YT tokens.

*Data NFTs* – The company will receive a 3YT token reward issued incrementally and equal to the square root of the total NFTs created by the company’s users. 

$$f_i\left(x\right)=\ \sqrt{f_{i-1}{(x)}^2+\ \sum{NFT}_{new}}$$
<p align="center"><sub>Fig. 2 Equation for incremental square root token payout</sub></p>

### III.	Proposal and Voting

The role of the DAO is to maintain the governance protocol for the TIKI data DEX. The DAO is responsible for defining and maintaining standards, guidelines, and processes. Maintenance occurs via a series of structured proposals and voting.

#### A.	Proposals

The proposal selection process has two phases, a Selection phase and a Voting phase. Both phases are accessible through the TIKI app by registered users. 

- Published Governance Protocol and Proposals are versioned and publicly accessible.

- Only registered users may participate in Selection, Voting, and Proposal submission. 

- Users can express support for or against any number of proposals in the Selection phase via thumbs-up/down buttons.

- Users may only support/vote once per proposal but may alter their vote at any time while voting is open.

- The Selection list is collated and published every week on Fridays at 17:00 (EST). Only proposals submitted at least 24 hours in advance qualify, providing Editors time to review. 

- Proposals remain open on the Selection list for 21 days.

-	After 21 days, the top five (Section III.B.a) move to the Voting phase for 1 week.

If two or more proposals modify the same part of the Governance Protocol, the proposals will be sequenced chronologically by submission time.

##### a.	Structure

*TIP Number* – A unique number automatically assigned to the proposal.

*Title* – A few words, not a complete sentence.

*Description* – One short sentence to describe the proposal.

*Authors* – A comma-separated list of the author's or author's TIKI username, wallet address, or email. For example, @TIKI_1, $NmJiZD…, mickey@mouse.com

*Discussions* – A URL pointing to the official discussion thread on Discord.

*Status* – Idea, Draft, Ready, Selection, Open, Approved, Rejected, Withdrawn, Living

*Type* – Standard Track, Core, Interface, Meta, Informational.

*Created* - Date created on, in ISO8601 format (YYYY-MM-DD).

*Linked (Optional)* – A link to another TIP

*Body* – The entire contents (code, text, etc.) of the proposal

##### b.	Status

*Idea* – An idea that is pre-draft. Ideas are not publicly tracked within the proposal repository.

*Draft* – The first formally tracked stage of a TIP in development. A TIP in Draft may be modified by the author(s) but has not been submitted for Selection.

*Ready* – A TIP marked by the author(s) as ready to be presented for Selection.

*Selection* – A TIP that is currently in the open Selection phase.

*Open* – A TIP that has been Selected and is currently open for official voting.

*Approved* – A TIP that the community has successfully approved.

*Rejected* – A TIP that did not pass the Selection or Voting phase requirements.

*Withdrawn* – The TIP Author(s) has withdrawn the proposed TIP. This state has finality and can no longer be resurrected using this TIP number. If the idea is pursued later, it is considered a new proposal.

*Living* – A special status for TIPs designed to be continually updated and not reach a state of finality.

##### c.	Types

*Governance* – Describes any change that modifies the published Governance Protocol. 

*Core* – Changes to the underlying technology that run/host the DAO and Governance Protocol but do not modify the Governance Protocol. 

*Interface* – Includes improvements around DAO interfaces such as mobile/web apps.

*Process* – Describes a process surrounding the DAO or proposes a change to (or an event in) a process. Process TIPs are like Standards Track TIPs but apply to areas other than the Governance Protocol. 

*Informational* – Describes a design issue or provides general guidelines or information to the TIKI community but does not propose a new feature. Informational TIPs do not necessarily represent TIKI community consensus or a recommendation, so users and implementers are free to ignore Informational TIPs or follow their advice.

##### d. Editors

Given the communal nature of the DAO, it is logical to have the proposals edited by fellow community members. Editors are responsible for reviewing proposals in the Draft and Ready status to improve clarity. Editors hold moderation power, to be used sparingly. Editors may move a proposal from Ready back to Draft in the event of a red flag like spam or criminal behaviour.  

Anyone with a good understanding of the TIP standardization and DAO process, intermediate-level experience on the technology and/or application side of the TIKI ecosystem, blockchain, and willingness to contribute to the process management may apply to become an Editor. Potential Editors should have the following skills:

- Good communication skills
- Ability to handle contentious discourse
- 1-5 spare hours per week

Anyone interested in becoming an Editor must understand the DAO and its processes, participate in the TIP process by commenting on and suggesting improvements to proposal requests and issues, and be familiar with the procedure. Other moderators monitor the contributions of newer moderators.

Anyone meeting the requirements may request to add themselves as an Editor. To become a full TIP Editor requires a majority approval vote of the existing Editors. Once approved, the new Editor will receive notifications of relevant proposals for review. 

#### B. Voting

Proposal voting happens in the TIKI app, with voting power determined by total reputation, calculated when voting opens. There are two stages in the voting process:

##### a. Proposal Selection

A user may upvote or downvote any proposal open for selection to determine which proposals move to official voting. Users may only voice their support once per proposal (via upvote/downvote) and may change their mind while Selection is open. Upvotes and downvotes carry equal weight (1). 

The top 5 proposals with the most support (total upvote/downvote) and a majority of positive support (more upvotes than downvotes) will then move forward to Proposal Voting.

##### b. Proposal Voting

The TIKI DAO utilizes three distinct voting pools to balance relative influence among various stakeholders. 

*People Pool* –all individuals voting on behalf of themselves

*Company Pool* – all votes cast on behalf of a company in the TIKI ecosystem 

*TIKI Pool* – a single vote cast on behalf of Tiki inc., the creators and maintainers of the data DEX.

Unlike traditional voting pools, where a binary vote is cast on behalf of the entire pool, DAO voting pools are a relative weight between 0 and a cap $(C)$. Votes placed $(V_p)$ within pools are calculated using quadratic [voting](https://en.wikipedia.org/wiki/Quadratic_voting) based on total reputation $(R)$.

User and Company Pools are equal in size and range from 0 to 45 with a scale factor $(SF)$ of 50. The smaller TIKI Pool ranges from 0 to 20. The sizing ensures that people and companies can collectively make decisions without TIKI buy-in. Likewise, a vote with significant user, company, and TIKI buy-in may also pass. 

*Proxy voting is not permitted. Wallets may only cast votes based on tokens earned prior to the opening of the vote*

$$
\displaylines{
V_p=\ \sqrt R\\
V_p=\ \min_c{\left(SF\ *\ \frac{\sum V_{p:yes}}{\sum V_p}\right)}
}
$$
<p align="center"><sub>Fig. 3 Equation for pooled voting</sub></p>

<p align="center">
  <img width=500 src="https://user-images.githubusercontent.com/3769672/211647812-248950d0-1de0-467b-9242-ddb959818b75.png"/>
  <br/>
  <sub>Fig. 4 Example Voting Outcomes</sub>
</p>

User and Company pools are additionally subject to a quorum requirement of 10% of the corresponding active user base. The quorum requirements are intended to be adjusted over time through DAO proposals to better reflect the active community. 

On completion of voting, the proposal's status is marked Final and recorded in the versioned proposal repository. Results are additionally displayed within the TIKI app. 


### IV. Governance Protocol

Each revision of the Governance Protocol and all tracked proposals will be hosted in a publicly accessible versioned repository. All versioning follows the semantic versioning standard ([Semver](https://semver.org)).

Upon proposal voting approval, the protocol is immediately amended, or in rare cases, as soon as practically possible.

Tiki inc. will publish the first version (1.0.0) of the Governance Protocol as a starting point for DAO maintenance and modification. 

Tiki inc., as the primary contributor to the TIKI data DEX, is responsible for publishing a list of amendments and versions supported, queued, and in progress.

### V. Legal

The DAO will be formed as a legal entity in Tennessee under the provisions set out in Senate Bill No. [2854](https://www.capitol.tn.gov/Bills/112/Amend/HA0748.pdf).

Tiki inc. as the operator of the TIKI data DEX is responsible for compliance with all applicable laws,  which take precedence over the Governance Protocol. 

The published Governance Protocol serves only as guidelines for the data DEX, representing the voice of the participants. Implementation and enforcement are ultimately at the discretion (no legal obligation) of the open-source contributors to the TIKI data DEX.  
