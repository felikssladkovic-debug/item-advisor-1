Feature: Review moderation
  In order to keep public content curated and trustworthy
  As a manager
  I want to review incoming user submissions and decide whether they become public

  Background:
    Given a manager account exists
    And a published Item exists
    And at least one pending review exists for that Item

  Scenario: Manager approves a pending review
    Given the manager is authenticated in admin context
    When the manager approves the pending review
    Then the review status becomes "APPROVED"
    And the review has moderated_at set
    And the review has moderated_by set
    And the related public aggregate values are refreshed
    And the approved review becomes visible on the public item page

  Scenario: Manager declines a pending review with reason
    Given the manager is authenticated in admin context
    When the manager declines the pending review with decline reason "Off-topic content"
    Then the review status becomes "DECLINED"
    And the review has moderated_at set
    And the review has moderated_by set
    And the review remains hidden from the public item page
    And the review appears in the user's cabinet with decline reason "Off-topic content"

  Scenario: Manager cannot decline without reason
    Given the manager is authenticated in admin context
    When the manager declines the pending review without a decline reason
    Then the request is rejected
    And the review status remains "PENDING"

  Scenario: Non-manager cannot moderate review
    Given a non-manager authenticated public user exists
    When the non-manager attempts to approve the pending review
    Then access is rejected

  Scenario: Pending review is never public before moderation
    Given a pending review exists for a published Item
    When an anonymous user opens the public item page
    Then the pending review is not visible

  Scenario: Only approved reviews affect public aggregates
    Given one pending review and one declined review exist for a published Item
    And neither review is approved
    When an anonymous user opens the public item page
    Then neither review affects approved review count
    And neither review affects average rating
