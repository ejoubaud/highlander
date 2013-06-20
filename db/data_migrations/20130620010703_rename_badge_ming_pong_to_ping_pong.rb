module DataMigration
  module MigrationFiles
    class RenameBadgeMingPongToPingPong < Base

      def up
        {
          '1_ming_pong_victory' => { name: '1_pong_victory', slug: '1-pong-victory', description: '1 Pong victory' },
          '10_ming_pong_victories' => { name: '10_pong_victories', slug: '10-pong-victories', description: '10 Pong victories' },
          '100_ming_pong_victories' => { name: '100_pong_victories', slug: '100-pong-victories', description: '100 Pong victories' }
        }.each do |old, opts|
          Badge.where(name: old).first.update(opts)
        end
      end

      def down
      end
    end
  end
end
