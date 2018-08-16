module Web::Controllers::Calendars
  module ParamsValidation
    def self.included(controller)
      controller.class_eval do
        params Class.new(Hanami::Action::Params) {
          predicate(:iso8601?, message: 'must conform to the date format (YYYY-MM-DD)') do |current|
            current.match(/\A\d\d\d\d-\d\d-\d\d\z/)
          end

          validations do
            optional(:id).filled(:int?)
            required(:calendar).schema do
              required(:title).filled(:str?, max_size?: 255)
              required(:starts_on).filled(:str?, :iso8601?)
              required(:ends_on).filled(:str?, :iso8601?)
            end
          end
        }

        private

        # dry-validationのcustom validation blockがネストしたparamsに
        # 対応していないので、Hanamiの機能を使わずバリデーションを実行する
        # https://github.com/dry-rb/dry-validation/pull/391
        def starts_on_preceeds_ends_on?(params)
          Date.parse(params.dig(:calendar, :starts_on)) < Date.parse(params.dig(:calendar, :ends_on))
        end
      end
    end
  end
end
