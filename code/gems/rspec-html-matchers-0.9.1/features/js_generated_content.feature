Feature: Javascript generated content

  Scenario: Test with js
    Given I have following template:
    """
    <!DOCTYPE html>
    <html>
      <head>
      <meta charset="utf-8">
      <title>HTML5 Template</title>
      </head>
      <body>
        <h1>Hello World!</h1>

        <script type="text/javascript">
          document.write('<p>Hello Another World!</p>');
        </script>
      </body>
    </html>
    """
    When I open this template in browser
    Then I should be able to match static content
    And I should be able to match javascript generated content
